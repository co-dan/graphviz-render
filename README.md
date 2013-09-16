# Embedding Graphviz in HTML Pages 

Original idea by [Yi Wang](https://github.com/wangkuiyi/graphviz-server/)

A screenshot is worth a thousand words:
![graphviz embedded](http://i.imgur.com/uMJbT.png)
![graphviz renderer](http://i.imgur.com/FJNMg.png)

# Serving 

A simple web-service was written in Haskell, which invokes Graphviz and returns a base64-encoded image upon a POST request.

# Rendering 

Dynamic rendering can be done with simple AJAX code

```javascript
    var d = $(dot_source_element).val();
    $.post(graphviz_server_path, d, function(data) {
      $(output_element).html('<img src=\"data:image/png;base64,' + data + '\" />');
    });
```

# Things that are missing  

- Caching
- Proper error handling 

# Set up guide 

1. Download [Haskell platform](http://hackage.haskell.org/platform/) and update the repository information:

   `cabal update`
    
2. Make sure you have [Graphviz](http://graphviz.org) installed
3. Download and install Scotty:

    ````
    git clone git://github.com/xich/scotty.git
    cd scotty; cabal install
    ```

4. Check out the source code to your machine and build it:

    ```
    git clone git://github.com/co-dan/graphviz-render.git
    cd graphviz-render
    cabal build
    ```

Then you can run the graphviz-render binary and you'll get a server running on port 3000
5. Play around with test.html and test2.html files
