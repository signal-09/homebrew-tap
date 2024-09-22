#!/usr/bin/env python

import argparse
import jinja2
import os
import requests
import subprocess


pypi_base_url = "https://pypi.org/pypi"


def get_pypi_info(pkg_name):
    """
    Get PyPI info
    """
    pkg_info_url = f"{pypi_base_url}/{pkg_name}/json"
    res = requests.get(pkg_info_url)

    if res.status_code != requests.codes.ok:
        print(f"Failed to fetch package info for {pkg_name}")
        exit(1)

    return res.json()


def get_requirements_txt(source_url, version):
    """
    Get requirements.txt from Git tag release
    """
    if not source_url:
        return ""

    requirements_url = source_url.replace("github", "raw.githubusercontent") + f"/refs/tags/{version}/requirements.txt"
    res = requests.get(requirements_url)

    return res.text if res.status_code == requests.codes.ok else ""


def pip_compile(requirements_txt):
    res = subprocess.check_output(
        [
            "pip-compile",
            "--quiet",
            "--no-header",
            "--no-annotate",
            "--strip-extras",
            "--output-file=-",
            "-"
        ],
        input=requirements_txt.encode()
    )
    return res.decode().splitlines()


def get_pkg_resource(req):
    try:
        pkg_name, version = req.split("==")
    except ValueError:
        print(f"Invalid line: {req}")
        exit(1)

    pkg_info_url = f"{pypi_base_url}/{pkg_name}/{version}/json"
    response = requests.get(pkg_info_url)

    if response.status_code != requests.codes.ok:
        print(f"Failed to fetch package info for {pkg_name}=={version}")
        exit(1)

    pkg_info = response.json()
    # Select the tar.gz distribution URL
    selected_url = next((url_info for url_info in pkg_info["urls"] if url_info["url"].endswith(".tar.gz")), None)

    if not selected_url:
        print(f"No .tar.gz distribution found for {pkg_name}=={version}")
        exit(1)

    download_url = selected_url["url"]
    sha256 = selected_url["digests"]["sha256"]

    return {"name": pkg_name, "url": download_url, "sha256": sha256}


def get_requirements(requirements_txt):
    req_lines = pip_compile(requirements_txt)
    requirements = []
    for req in req_lines:
        if req:
            requirements.append(get_pkg_resource(req))
    return requirements


def template(pkg_name, version, download_url, sha256, requirements):
    template_path = os.path.join(os.path.dirname(__file__), "../Formula")
    environment = jinja2.Environment(loader=jinja2.FileSystemLoader(template_path))
    template_file = f"{pkg_name}.rb.j2"
    formula_file = os.path.join(template_path, f"{pkg_name}.rb")
    formula_template = environment.get_template(template_file)
    content = formula_template.render(
        pkg_name=pkg_name,
        version=version,
        download_url=download_url,
        sha256=sha256,
        requirements=requirements
    )
    with open(formula_file, mode="w", encoding="utf-8") as formula:
        formula.write(content)


def parse_packages(packages):
    for pkg_name in packages:
        pkg_info = get_pypi_info(pkg_name)

        source_url = pkg_info["info"].get("project_urls", {}).get("Source")
        version = pkg_info["info"]["version"]
        release_info = pkg_info["releases"][version]

        selected_url = next((url_info for url_info in release_info if url_info["url"].endswith(".tar.gz")), None)
        if not selected_url:
            print(f"No .tar.gz distribution found for {pkg_name}=={version}")
            exit(1)

        download_url = selected_url["url"]
        sha256 = selected_url["digests"]["sha256"]

        requirements_txt = get_requirements_txt(source_url, version)
        requirements = get_requirements(requirements_txt)

        template(pkg_name, version, download_url, sha256, requirements)
        print(f"Updated {pkg_name} to version {version}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create homebrew formula from template.")
    parser.add_argument(
        "packages",
        metavar="PACKAGE",
        type=str,
        nargs="+",
        help="package name as seen under https://pypi.org/pypi/<package>/"
    )

    args = parser.parse_args()
    parse_packages(args.packages)
