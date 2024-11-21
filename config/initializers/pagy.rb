Pagy::DEFAULT[:limit] = 10 # items per page
Pagy::DEFAULT[:size]  = 10  # nav bar links
Pagy::DEFAULT[:theme] = "tailwind"
# Better user experience handled automatically
require "pagy/extras/overflow"
Pagy::DEFAULT[:overflow] = :last_page
