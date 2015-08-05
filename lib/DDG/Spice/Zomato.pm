package DDG::Spice::Zomato;
# ABSTRACT: Write an abstract here
# Start at https://duck.co/duckduckhack/spice_overview if you are new
# to instant answer development

use strict;
use DDG::Spice;

name "Restaurants Search";
source "Zomato";
icon_url "https://www.zomato.com/images/logo/zomato_favicon3.png";
description "Suggest restaurants or places to eat in and around a locality";
primary_example_queries "restaurants in gurgaon", "restaurants in bangalore";
secondary_example_queries "restaurants nearby gurgaon","places to eat in gurgaon","food places in gurgaon";
category "food";
topics "food_and_drink","entertainment","social";
code_url "https://github.com/duckduckgo/zeroclickinfo-spice/blob/master/lib/DDG/Spice/Zomato.pm";
attribution github => ["Zomato", "Zomato"],
            twitter => "Zomato",
            facebook => "zomato",
            web => ["https://www.zomato.com","Zomato"];


spice is_cached => 0;
spice to => 'http://dheerajavvari.zdev.net/duckduckgo_api.php?q=$1&lat=$2&lon=$3&lang_code=$4&rtl=$5&callback={{callback}}';
spice from => '([^/]+)/([^/]+)/([^/]+)/([^/]+)/([^/]+)';
spice wrap_jsonp_callback => 1;


triggers start => "restaurants in", "restaurants at", "restaurants near", "restaurants nearby", "places to eat in", "places to eat at", "places to eat near", "places to eat nearby", "food places in", "food places at", "food places near", "food places nearby";
triggers end => "restaurants","food palces","food courts";


handle remainder => sub {

    my $query = lc $_;
    $query =~ s/\?//;
    
   # my $type;
   # if ($query =~ /in|at|near|nearby|near by/) {
   #     $type = "one";
   # } elseif ($query =~ /me|my location/) {
   #     $type = "two";
   # } else {
   #     return;
   # }
    
    return ($query, $loc->latitude, $loc->longitude, $lang->locale, $lang->rtl) if (length $query >= 2);
    return;
};

1;