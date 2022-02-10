# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags
    {
      site: "MediPet",
      reverse: true,
      charset: "utf-8",
      description: "ペットのお薬の登録管理サービス",
      og: {
        title: "MediPet",
        description: :description,
        type: "website",
        url: "https://medi-pet.herokuapp.com",
        image: "https://medi-pet.herokuapp.com/ogp/ogp.png",
        locale: "ja_JP"
      },
      twitter: {
        title: "MediPet",
        card: "summary_large_image",
        description: :description,
        image: "https://medi-pet.herokuapp.com/ogp/ogp.png",
        domain: "https://medi-pet.herokuapp.com"
      }
    }
  end
end
