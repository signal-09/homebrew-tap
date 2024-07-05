class Iproute4mac < Formula
  include Language::Python::Virtualenv

  desc "iproute for Mac"
  homepage "https://github.com/signal-09/iproute4mac"
  version "0.1.4"
  url "https://files.pythonhosted.org/packages/fe/b1/e70075e4c10babf03f3c56ac68297650a96842dd5daf279fce76c03c32fa/iproute4mac-0.1.4.tar.gz"
  sha256 "9a31e11ae0ac17fe96ff3011b67b5f8c8353e878c4643518101ba44e44abdabc"
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
