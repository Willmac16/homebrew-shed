class Plotjuggler < Formula
  desc "The Time Series Visualization Tool that you deserve."
  homepage "https://www.plotjuggler.io"
  license "MPL-2.0"

  head "https://github.com/facontidavide/PlotJuggler.git", branch: "main"

  stable do
    url "https://github.com/facontidavide/PlotJuggler/archive/refs/tags/3.8.4.tar.gz"
    sha256 "0e2883326f231247633244c08519ec21476d71cb414218c1218ed6a3c77786ab"

    patch :DATA
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

# Patch to fix build on macOS. PR against upstream: #905
__END__
diff --git a/plotjuggler_plugins/ParserProtobuf/CMakeLists.txt b/plotjuggler_plugins/ParserProtobuf/CMakeLists.txt
index 084c93cb..084246a6 100644
--- a/plotjuggler_plugins/ParserProtobuf/CMakeLists.txt
+++ b/plotjuggler_plugins/ParserProtobuf/CMakeLists.txt
@@ -21,6 +21,14 @@ if( Protobuf_FOUND)
         protobuf_parser.h
         ${UI_SRC}  )

+    if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
+        find_library(ABSL_SPINLOCK_WAIT_LIB absl_spinlock_wait)
+
+        target_link_libraries(ProtobufParser
+            ${ABSL_SPINLOCK_WAIT_LIB}
+            )
+    endif()
+
     target_link_libraries(ProtobufParser
         ${Qt5Widgets_LIBRARIES}
         ${Qt5Xml_LIBRARIES}
