module Rules
  class Duplicates
    arr = User.where.not(uniid: 'naujas').order(created_at: :desc).pluck(:uniid)
  end
end