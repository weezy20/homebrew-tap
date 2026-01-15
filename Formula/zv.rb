class Zv < Formula
  desc "Ziglang Version Manager and Project Starter"
  homepage "https://github.com/weezy20/zv"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/weezy20/zv/releases/download/v0.9.0/zv-aarch64-apple-darwin.tar.gz"
      sha256 "3d7e41d3190766265c1908106596ed01a90a871e06558b4caddc6ffd52777f92"
    end
    if Hardware::CPU.intel?
      url "https://github.com/weezy20/zv/releases/download/v0.9.0/zv-x86_64-apple-darwin.tar.gz"
      sha256 "3922a1cb958f28afbb5f5f15e1d117b41e5ba78948391d2a8a74916057d509e8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/weezy20/zv/releases/download/v0.9.0/zv-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1033e0dc70155de70824c25105cbdcc4e4c70aed72b0f7448ebdae442bd1ffdb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/weezy20/zv/releases/download/v0.9.0/zv-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "904fd7179c8625427e724be0a52235dbd99abd6eb59b333e4a0d2f2a590755c7"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "zv" if OS.mac? && Hardware::CPU.arm?
    bin.install "zv" if OS.mac? && Hardware::CPU.intel?
    bin.install "zv" if OS.linux? && Hardware::CPU.arm?
    bin.install "zv" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
