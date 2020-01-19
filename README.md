<h1 align="center">
  <img src="https://upload.wikimedia.org/wikipedia/en/2/22/Heckert_GNU_white.svg" width="120"><br>
  MAKEFILES<br>
  <sup><sub><sup><sub>FOR GOLANG/SERVERLESS</sub></sup></sub></sup>
</h1>

This is a collection of [`Make`](https://www.gnu.org/software/make/) files that support the development of Golang-based AWS Lambda functions. It was put together to be used in conjunction with [`Modern Make`](https://github.com/tj/mmake) (`mmake`).

## Installing

You'll need `mmake`. On MacOS, if using homebrew, run the following to install it (please refer to the [documentation](https://github.com/tj/mmake#installation) for other ways of installation):

```shell
$ brew tap tj/mmake https://github.com/tj/mmake.git
$ brew install tj/mmake/mmake
```

Then, on your `Makefile`, use the `include` directive to include this collection as remote includes (feature provided by `mmake`):

```Makefile
include github.com/InDebted/make/index
```

Running `mmake help` will fetch the remote includes and print you all the documented targets. If you need to fetch an updated copy of the remote includes, run `mmake update`.

---

<p align="center">
    <a href="https://indebted.co"><img src="https://avatars3.githubusercontent.com/u/17794454?s=350&v=4" width="24"></a><br>
</p>