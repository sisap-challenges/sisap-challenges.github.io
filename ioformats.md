+++
title = "Input and output formats"
hascode = true
rss_title = "I/O formats"
rss_pubdate = Date(2023, 2, 10)

tags = ["io", "input", "output", "hdf5", "npz"]
+++


# About file formats
We will find several kinds of files. For instance, LIAON parts come in two formats: `.npz` for embeddings[^1] and `.parquet` files for metadata[^2].
We use HDF5 files[^3] (`.h5`) extensively for datasets, projections, queries, and gold standards, and we also require result files to be HDF5 files. HDF5 files can contain tree-like organization and may include several kinds of data, working well among platforms.

[^1]: Numpy files can be loaded with [`numpy.load`](https://numpy.org/doc/stable/reference/generated/numpy.load.html) in Python and with package [`NPZ.jl`](https://github.com/fhs/NPZ.jl) in Julia.

[^2]: The [pyarrow](https://arrow.apache.org/docs/python/index.html) package provide support for parquet files in Python. Julia users can use the [`Parquet2.jl`](https://expandingman.gitlab.io/Parquet2.jl/) package.

[^3]: High-performance data management and storage suite <https://www.hdfgroup.org/solutions/hdf5/>. In Python, these files can be loaded and created with [`h5py`](https://www.h5py.org/). Julia users can use [`HDF5.jl`](https://juliaio.github.io/HDF5.jl/) or [`JLD2.jl`]( https://github.com/JuliaIO/JLD2.jl/).
