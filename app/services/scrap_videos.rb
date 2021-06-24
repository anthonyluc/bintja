class ScrapVideos
    
    def self.youtube(recipe_query)

        yt_recipes_hash = {}
        tab_url = []
        tab_img = []
        tab_title = []

        ### Méthode Scrapping
        ## On transforme la requête pour YT
        # recipe_query.gsub!(' ', '+')
        # url = "https://www.youtube.com/results?search_query=recipe+#{recipe_query}"

        # URI.open(url) {|f|
        #     f.each_line {|line| 
        
        #         line.scan(/"videoRenderer":{"videoId":"([\d\D][^"]*)/) {|x|                    
        #             tab_url << "https://www.youtube.com/watch?v=#{x.shift.strip}"
        #         }
                
        #         line.scan(/"thumbnails":\[{"url":"(https:\/\/i\.ytimg\.com\/vi\/[\d\D][^?]*\.jpg)/) {|y|
        #             tab_img << "#{y.shift.strip}"
        #         }
        
        #         line.scan(/"title":{"runs":\[{"text":"([\d\D][^"]*)/) {|z|
        #             tab_title << "#{z.shift.strip}"
        #         }
        #     }
        # }

        # yt_recipes_hash = {title: tab_title, url: tab_url, img: tab_img}

        ### Méthode API Youtube Data v3        
        # On transforme la requête pour YT
        recipe_query.gsub!(' ', '+')
        url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=recipe+#{recipe_query}&maxResults=48&key=#{ENV['API_YT_DATA_V3']}"
        response_url = RestClient.get(url)

        response_json = JSON.parse(response_url)

        response_json["items"].each do |r|
            tab_url << "https://www.youtube.com/watch?v=#{r["id"]["videoId"]}"
            tab_title << "#{r["snippet"]["title"]}"
            tab_img << "#{r["snippet"]["thumbnails"]["high"]["url"]}"
        end

        yt_recipes_hash = {title: tab_title, url: tab_url, img: tab_img}

        return yt_recipes_hash.to_s
    end
end