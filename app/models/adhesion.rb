# == Schema Information
#
# Table name: adhesions
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid
#  team_id    :bigint
#
class Adhesion < ApplicationRecord
  belongs_to :user
  belongs_to :team
end
