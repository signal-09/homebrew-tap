class Iproute4mac < Formula
  include Language::Python::Virtualenv

  desc "CLI wrapper for iproute2 Linux routing utilities"
  homepage "https://pypi.org/project/iproute4mac/"
  url "https://pypi.io/packages/source/i/iproute4mac/iproute4mac-0.4.3.tar.gz"
  sha256 "c3be1df7005ac03dc449331021101e09f7681990518336deb9add8059a311e82"
  license "Apache-2.0"

  depends_on :macos
  depends_on "python@3.12"

  conflicts_with "iproute2mac", because: "both provide same executables"

  def install
    virtualenv_install_with_resources
  end

  test do
    output = shell_output("#{bin}/ip addr").strip
    assert_match "link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00", output
  end
end
