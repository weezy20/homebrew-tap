class Zv < Formula
  desc "Ziglang Version Manager and Project Starter"
  homepage "https://github.com/weezy20/zv"
  version "0.9.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/weezy20/zv/releases/download/v0.9.2/zv-aarch64-apple-darwin.tar.gz"
      sha256 "a11c65412e566d5255bfb5207591ff9e151a5fa91098bbda24543904d2ba81f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/weezy20/zv/releases/download/v0.9.2/zv-x86_64-apple-darwin.tar.gz"
      sha256 "c055fc428c599c3a9b72ab4d5ca85234637896f7f2c5ac3a829475e3a9053828"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/weezy20/zv/releases/download/v0.9.2/zv-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a14174c2324695199234af5f7426f0791b8c1ea82e1bc376642e3def88ab6f0d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/weezy20/zv/releases/download/v0.9.2/zv-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f6285f32d2bbc34bfc82d2285d3ca0de5357821a21bd82ed7c2aa39c692618b6"
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
