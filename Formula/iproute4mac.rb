class Iproute4mac < Formula
  include Language::Python::Virtualenv

  desc "iproute for Mac"
  homepage "https://github.com/signal-09/iproute4mac"
  version "0.1.3"
  url "https://files.pythonhosted.org/packages/08/2f/95896c61381863674982c8c7987ac8b8811a4b693db127565c82d68c2934/iproute4mac-0.1.3.tar.gz"
  sha256 "c838c30e3f1248956d0d7bbc7112ce8b9b1b72c19d92549d43da16796a302f08"
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
