# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags
    {
      site: "MediPet",
      reverse: true,
      charset: "utf-8",
      description: "ペットのお薬手帳",
      og: {
        title: :title,
        description: :description,
        type: "website",
        url: "",  # デプロイ後に設定
        image: "",  # デプロイ後に設定
        locale: "ja_JP",
      },
      twitter: {
        card: "summary",
        title: "MediPet",
        image: "",  # デプロイ後に設定
        description: :description,
      }
    }
  end
end
