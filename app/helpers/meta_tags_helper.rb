# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags
    {
      site: "MediPet",
      reverse: true,
      charset: "utf-8",
      description: "ペットの薬の登録管理サービス",
      og: {
        title: "MediPet",
        description: :description,
        type: "website",
        url: "https://medi-pet.herokuapp.com",
        image: "MediPet.png",
        locale: "ja_JP"
      },
      twitter: {
        title: "MediPet",
        card: "summary",
        image: "MediPet.png",
        description: :description,
        domain: "https://medi-pet.herokuapp.com"
      }
    }
  end
end
