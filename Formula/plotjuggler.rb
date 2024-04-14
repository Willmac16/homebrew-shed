class Plotjuggler < Formula
  desc "The Time Series Visualization Tool that you deserve."
  homepage "https://www.plotjuggler.io"
  license "MPL-2.0"

  head "https://github.com/facontidavide/PlotJuggler.git", branch: "main"

  stable do
    url "https://github.com/facontidavide/PlotJuggler/archive/refs/tags/3.9.1.tar.gz"
    sha256 "2c36df6a62d6e5a16f771e40abeb7df0cdf9912327c3f7f4f93a39b962911b2f"
  end

  depends_on "cmake" => :build
  depends_on "protobuf"
  depends_on "mosquitto"
  depends_on "qt@5"
  depends_on "zeromq"
  depends_on "zstd"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build", "--config", "RelWithDebInfo", "--target", "install"
  end


  test do
    system "#{bin}/plotjuggler", "--version"
  end
end
