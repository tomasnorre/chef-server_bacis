server_basic Cookbook
=====================
This cookbook install/setup a set of preferred applications and configurations I want on all my server nodes. The cookbook also contains a subset of applications that I do not want on my server nodes.

[![Build Status](https://travis-ci.org/tomasnorre/chef-server_bacis.svg)](https://travis-ci.org/tomasnorre/chef-server_bacis)

#### server_basic::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `server_basic` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[server_basic]"
  ]
}
```

You can also set your timezone if the default `Europe/Copenhagen` do not match your needs with following:

```json
{
  "nodeinfo": {
    "timezone": "America/Chicago",
  },
}
````

Contributing
------------
e.g.

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

Authors
-------------------
* [Tomas Norre Mikkelsen](http://github.com/tomasnorre)

License
-------

The MIT License (MIT)

Copyright (c) 2015 - Tomas Norre Mikkelsen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
