class Iproute4mac < Formula
  include Language::Python::Virtualenv

  desc "iproute for Mac"
  homepage "https://github.com/signal-09/iproute4mac"
  version "0.1.6"
  url "https://files.pythonhosted.org/packages/36/50/054f89d2f8c059ece41752fafb565d67549ba5bee2589b8c188c9494afb0/iproute4mac-0.1.6.tar.gz"
  sha256 "ffd02ad927520145803d110a8c80264ffa6b745a9cd1f9af9eb591b1a233a2c6"
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
