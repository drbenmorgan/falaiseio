# falaiseio

Experimental [PODIO](https:://github.com/hegner/podio) datamodel and I/O for
SuperNEMO.

Evaluation program/use cases:

1. Construct, use and understand basic event loop in PODIO-land
2. Generate PODIO data model for SuperNEMO `RawData` (trigger info, geiger hits, calorimeter hits)
  1. Understand requirements/limitations on data model components/datatypes
  2. what about Metadata (i.e. run-level) data?
3. Use `RawData` model in event loop
  1. read/create data
  2. do something with it (e.g. plots)
4. Generate data model for `CalibratedData` (trigger info, geiger hits, calorimeter hits)
  1. References/links between raw/calibrated hits (e.g. "this calibrated hit created from this raw hit")
5. Use `RawData` and `CalibratedData` in a "pipeline/event loop", i.e. in terms of current processing model:
   
   ```python
   source dataSource(ofRawEvents)
   sink output(forOtherUse)
   
   for event in dataSource:
     # "event" just holds "RawData"
     
     calibrate(event)
     # "event" now holds "RawData" and associated "CalibratedData"
     
     # ... possible further steps of processing with additional "banks" of data added (e.g. clusters of hits)
     
     output(event)
     # ... persist data to a destination
     
   ```
   
   This is thinking in terms of an ``Event`` object holding data, need to learn how PODIO structures this
   and what, if any, additional layers are needed for structuring/pipelining etc.

## Building the project

    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=<installdir> [-Dfalaiseio_BUILD_DOCS=ON] <path to sources>
    make -j<number of cores on your machine>
    make install

The `falaiseio_BUILD_DOCS` variable is optional, and should be passed if you wish to
build the Doxygen based API documentation. Please note that this requires an existing
installation of [Doxygen](http://www.doxygen.org/index.html). If CMake cannot locate
Doxygen, its install location should be added into `CMAKE_PREFIX_PATH`.
For further details please have a look at [the CMake tutorial](http://www.cmake.org/cmake-tutorial/).

## Building the documentation

The documentation of the project is based on doxygen. To build the documentation,
the project must have been configured with `falaiseio_BUILD_DOCS` enabled, as
described earlier. It can then be built and installed:

    make doc
    make install

By default, this installs the documentation into `<installdir>/share/doc/falaiseio/doxygen`.

## Creating a package with CPack

A cpack based package can be created by invoking

    make package

## Running the tests

To run the tests of the project, first build it and then invoke

    make test

## Inclusion into other projects

If you want to build your own project against falaiseio, CMake may be the best option for you. Just add its location to `CMAKE_PREFIX_PATH` and call `find_package(falaiseio)` within your CMakeLists.txt.

A `pkg-config` `.pc` file is also installed if you do not use CMake.
Simply add the location of the `.pc` file (nominally `<installdir>/lib/pkgconfig`) and run `pkg-config --cflags --libs falaiseio` to get the
include paths and libraries needed to compile and link to falaiseio.
