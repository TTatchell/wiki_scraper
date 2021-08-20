class NoPageError < StandardError
    def message
        "Page not found"
    end
end