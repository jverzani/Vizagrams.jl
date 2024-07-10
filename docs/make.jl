using Vizagrams
using Documenter

DocMeta.setdocmeta!(Vizagrams, :DocTestSetup, :(using Vizagrams); recursive=true)

makedocs(sitename="Vizagrams.jl",
    format=Documenter.HTML(size_threshold=nothing),
    pages=[
        "Home" => "index.md",
        "Tutorials" => [
            "1 - Diagramming Basics" => "tutorials/1_basics.md"
            "2 - Custom Marks" => "tutorials/2_custommarks.md"
            "3 - Data Vizualization Basics" => "tutorials/3_datavisualization.md"
            "4 - Increasing Expressiveness" => "tutorials/4_expressiveness.md"
            "5 - Customizing Visualizations" => "tutorials/5_customization.md"
        ],
        "Gallery" => "gallery.md",
    ]
)

deploydocs(; repo="github.com/davibarreira/Vizagrams.jl")
