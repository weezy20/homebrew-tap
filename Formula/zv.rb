class Zv < Formula
  desc "Ziglang Version Manager and Project Starter"
  homepage "https://github.com/weezy20/zv"
  url "https://github.com/weezy20/zv/releases/download/v0.11.1/zv-x86_64-apple-darwin.tar.gz"
  version "0.11.1"
  sha256 "934733e39304ff48373f49c729c015a6b3a6f42475983e9ea0fd83fed96e76ee"
  license "MIT"

  on_arm do
    url "https://github.com/weezy20/zv/releases/download/v0.11.1/zv-aarch64-apple-darwin.tar.gz"
    sha256 "6b02e9d2ee24a4cf714b7c33fc723e08b1f1d3b809ad6167e90cca71a39182ee"
  end

  def install
    mkdir_p libexec
    mv "zv", "\#{libexec}/zv"
    chmod 0755, "\#{libexec}/zv"
    mkdir_p bin
    ln_s "\#{libexec}/zv", "\#{bin}/zv"
  end

  def caveats
    <<~EOS
      zv is installed at \#{libexec}/zv with a symlink at \#{bin}/zv.

      Data directory: ~/.local/share/zv
      Run  to configure your shell environment.
    EOS
  end

  test do
    assert_match "zv", shell_output("\#{bin}/zv --version")
  end
end
