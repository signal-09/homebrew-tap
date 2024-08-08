class Iproute4mac < Formula
  include Language::Python::Virtualenv

  desc "iproute for Mac"
  homepage "https://github.com/signal-09/iproute4mac"
  version "0.2.1"
  url "https://files.pythonhosted.org/packages/0a/b3/f851a6742aef125dd5219268cc170a0a5a1e6a6ce33e1bacd6300afc5225/iproute4mac-0.2.1.tar.gz"
  sha256 "f252544845e9cba386ddbaa44af03d422c0fa62971bafaf262d1603c6803d7a5"
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
