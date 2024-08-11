class Iproute4mac < Formula
  include Language::Python::Virtualenv

  desc "iproute for Mac"
  homepage "https://github.com/signal-09/iproute4mac"
  version "0.3.0"
  url "https://files.pythonhosted.org/packages/21/07/c911d72dad03c7ccd32d606565bc8ada1e8b16c03aac98c25f849f89ced9/iproute4mac-0.3.0.tar.gz"
  sha256 "72b46c3924e4f06afe8f47c440632d1d655de4b9af8cf6f01a9390ecbd47841f"
  head "https://github.com/signal-09/iproute4mac.git", branch: "master"

  depends_on :macos
  depends_on "python@3.12"

  conflicts_with "iproute2", "iproute2mac", because: "both provide same executables"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/ip -Version"
  end
end
