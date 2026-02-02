class Iproute4mac < Formula
  include Language::Python::Virtualenv

  desc "CLI wrapper for iproute2 Linux routing utilities"
  homepage "https://pypi.org/project/iproute4mac/"
  url "https://pypi.io/packages/source/i/iproute4mac/iproute4mac-0.6.0.tar.gz"
  sha256 "80862f6f6cd7fd84c4a30edbbaa5a46b391c246d1f356932323c68ac88415bfa"
  head "https://github.com/signal-09/iproute4mac.git", branch: "master"
  license "Apache-2.0"

  depends_on :macos
  depends_on "python@3.14"

  conflicts_with "iproute2mac", because: "both provide same executables"

  resource "pbr" do
    url "https://files.pythonhosted.org/packages/5e/ab/1de9a4f730edde1bdbbc2b8d19f8fa326f036b4f18b2f72cfbea7dc53c26/pbr-7.0.3.tar.gz"
    sha256 "b46004ec30a5324672683ec848aed9e8fc500b0d261d40a3229c2d2bbfcedc29"
  end

  def install
    virtualenv_install_with_resources
    share.install prefix/"libexec/share/man" if !Dir[prefix/"libexec/share/man"].empty?
  end

  test do
    output = shell_output("#{bin}/ip addr").strip
    assert_match "link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00", output
  end
end
