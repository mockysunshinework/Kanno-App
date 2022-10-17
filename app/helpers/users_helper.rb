module UsersHelper

	# 渡されたユーザーがログイン済みのユーザーであればtrueを返します。
	def current_user?(user)
		user == current_user
	end    
end
