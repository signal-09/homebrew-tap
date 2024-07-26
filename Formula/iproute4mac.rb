class Iproute4mac < Formula
  include Language::Python::Virtualenv

  desc "iproute for Mac"
  homepage "https://github.com/signal-09/iproute4mac"
  version "0.1.7"
  url "https://files.pythonhosted.org/packages/fb/dd/682148691fdb34df38e8866d912b1a3edbab970d8b05f8aba4b3b6157248/iproute4mac-0.1.7.tar.gz"
  sha256 "46807f6bd990182ccf307c0a32aa3330d9d0ff756b9d89d91c679dfe7cad18d4"
  head "https://github.com/signal-09/iproute4mac.git", branch: "master"

  depends_on :macos
  depends_on "python@3.12"

  conflicts_with "iproute2mac", because: "iproute2mac provides same executables"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/ip -Version"
  end
end
