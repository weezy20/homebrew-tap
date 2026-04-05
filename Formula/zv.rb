class Zv < Formula
  desc "Ziglang Version Manager and Project Starter"
  homepage "https://github.com/weezy20/zv"
  url "https://github.com/weezy20/zv/releases/download/v0.10.0/zv-x86_64-apple-darwin.tar.gz"
  version "0.10.0"
  sha256 "496ebc7b2d742ba70abeea8a044b80476d5540c6ae18fdad317c78ee25d3af1c"
  license "MIT"

  on_arm do
    url "https://github.com/weezy20/zv/releases/download/v0.10.0/zv-aarch64-apple-darwin.tar.gz"
    sha256 "8ec97da6c1bbed8f40e79900ed1746082639a7a8557f663b8371446ac8bf4e00"
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
