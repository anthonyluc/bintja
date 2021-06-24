class ScrapVideoInfo
    
    def self.youtube(yt_video_id)

        yt_recipes_hash = {}
        tab = []

        ### Méthode scrapping
        # On transforme la requête pour YT
        url = "https://www.youtube.com/watch?v=#{yt_video_id}"

        # On ouvre le lien
        html_doc = Nokogiri::HTML(URI.open(url).read)
        # On récupère seulement le head meta
        my_scrap = html_doc.search('head meta').to_s

        # Scan les infos puis supprime les [] du regex
        my_scrap.scan(/<meta property="og:[url|title|image].*content="(.*)">/) {|x|
            #On intègre dans le tableau
            tab << x.shift.strip 
        }
        # On enregistre dans un hash
        yt_recipes_hash[tab[1]] = {url: tab[0], image: tab[2]} 

        ### Méthode API Youtube Data v3
        # url = "https://www.googleapis.com/youtube/v3/videos?part=snippet&id=#{yt_video_id}&key=#{ENV['API_YT_DATA_V3']}"
        # response_url = RestClient.get(url)
        # response_json = JSON.parse(response_url)

        # title_vid = response_json["items"][0]["snippet"]["title"]
        # image_vid = response_json["items"][0]["snippet"]["thumbnails"]["high"]["url"]
        # yt_recipes_hash[title_vid] = {url: "https://www.youtube.com/watch?v=#{yt_video_id}", image: image_vid} 

        return yt_recipes_hash.to_s
    end
end