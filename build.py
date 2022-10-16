#!/usr/bin/env python3

import argparse
import contextlib
import glob
import os
import shutil
import subprocess
import sys
from pathlib import Path

BUILD_DIR = Path("./build")
PROJECT_ROOT = "."


@contextlib.contextmanager
def cd(path):
    prev_cwd = Path.cwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(prev_cwd)


def clean():
    print("Cleaning up")
    paths = list(glob.glob("./build/*"))
    for p in paths:
        shutil.rmtree(p)

    print("Build dir clean")


def build_file(path: Path):
    if path.parts[-1].endswith("tex"):
        out_path = Path(BUILD_DIR) / path.parent
        out_path.mkdir(
            parents=True,
            exist_ok=True,
        )
        full_out_path = out_path.absolute()
        print(f"Compiling to {out_path.absolute()}")
        with cd(path.parent):
            subprocess.check_call(
                [
                    "pdflatex",
                    "-output-directory",
                    full_out_path,
                    path.name,
                ]
            )
    else:
        print("Please provide a file .tex file path")
        sys.exit(1)


def build(path: Path | None):
    if path is not None and path.exists():
        # Compile only the given path
        build_file(path)
    else:
        # Compile everything
        print("Compiling all the files")
        source_paths = list(Path(PROJECT_ROOT).glob("**/*.tex"))
        for p in source_paths:
            build_file(p)

    sys.exit(0)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        "build.py", description="Build and clean script for the repo"
    )
    parser.add_argument(
        "-c",
        "--clean",
        dest="clean",
        action="store_true",
        help="Delete all pdflatex auxiliary files",
    )
    parser.add_argument(
        "-a",
        "--build-all",
        dest="build_all",
        action="store_true",
        help="Build everything in the repo",
    )
    parser.add_argument("target", nargs="?", default=None, type=Path)

    args = vars(parser.parse_args())
    if args["clean"]:
        clean()

    if args["build_all"] and args["target"] is None:
        print("Building everything")
        build(None)

    if args["target"] is not None:
        print(f'Building {args["target"]}')
        build(args["target"])
