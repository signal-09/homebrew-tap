class Iproute4mac < Formula
  include Language::Python::Virtualenv

  desc "iproute for Mac"
  homepage "https://github.com/signal-09/iproute4mac"
  version "0.1.1"
  url "https://files.pythonhosted.org/packages/a1/d7/a90f6c7047e946570e9a846abe6053267d760cd31c0d1216b6f1c876e7cc/iproute4mac-0.1.1.tar.gz"
  sha256 "3d37cc6584b0c24ed74cefa8a85439eacec4061b21b5caac9543e98209304035"
  head "https://github.com/signal-09/iproute4mac.git", branch: "master"

  depends_on :macos
  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/ip -Version"
  end
end
