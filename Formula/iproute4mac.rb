class Iproute4mac < Formula
  include Language::Python::Virtualenv

  desc "CLI wrapper for iproute2 Linux routing utilities"
  homepage "https://pypi.org/project/iproute4mac/"
  url "https://pypi.io/packages/source/i/iproute4mac/iproute4mac-0.5.6.tar.gz"
  sha256 "471b78fc4a64a6fbbae46084cd2682d3cf7c72705e80080a61e985037d374dec"
  head "https://github.com/signal-09/iproute4mac.git", branch: "master"
  license "Apache-2.0"

  depends_on :macos
  depends_on "python@3.12"

  conflicts_with "iproute2mac", because: "both provide same executables"

  resource "pbr" do
    url "https://files.pythonhosted.org/packages/b2/35/80cf8f6a4f34017a7fe28242dc45161a1baa55c41563c354d8147e8358b2/pbr-6.1.0.tar.gz"
    sha256 "788183e382e3d1d7707db08978239965e8b9e4e5ed42669bf4758186734d5f24"
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
