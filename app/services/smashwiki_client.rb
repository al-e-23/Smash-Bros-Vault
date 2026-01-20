require "faraday"
require "json"

class SmashwikiClient
    BASE_URL = "https://www.ssbwiki.com/api.php"

    def initialize
        @conn = Faraday.new(url: BASE_URL)
    end

    # Returns the page title of the character that is searched
    def search_title(query)
        res = @conn.get("", {
            action: "query",
            format: "json",
            list: "search",
            srsearch: query,
            srlimit: 1,
            utf8: 1
        })

        data = JSON.parse(res.body)
        data.dig("query", "search", 0, "title")
    end

    # Returns an image for the given page
    def image_url_for(title, size:500)
       res = @conn.get("", {
            action: "query",
            format: "json",
            prop: "pageimages",
            piprop: "thumbnail",
            pithumbsize: size,
            formatversion: 2,
            titles: title
        })

        data = JSON.parse(res.body)
        data.dig("query", "pages", 0, "thumbnail", "source")
    end 
end