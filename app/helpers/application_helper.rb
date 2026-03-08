module ApplicationHelper
  def random_character_image
    images = Dir.glob(Rails.public_path.join("images/characters/*"))
    return nil if images.empty?

    path = images.sample
    "/images/characters/#{File.basename(path)}"
  end
end
