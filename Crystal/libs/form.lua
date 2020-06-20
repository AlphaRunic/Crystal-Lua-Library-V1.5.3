local m,s,t,smt = math,string,table,setmetatable

Form = {
	new = function(questions, a)
		local self = {
			Questions = questions or {},
			Answers = {},
			Correct = 0,
			Incorrect = 0,
			Completed = false
		}
		answers = {};
		for k, ans in pairs(a) do
			ans = s.lower(ans)
			answers[k] = ans
		end
		local function AskQuestion(q,n)
			print(n..'.) '..q)
			t.insert(self.Answers,#self.Answers+1,
			{ans=s.lower(io.read())}
			)
		end
		function self:Start()
			for question_number = 1,#questions do
				AskQuestion(questions[question_number],question_number)
			end
			self.Completed = true
		end
		function self:Eval()
			for i,v in pairs(self.Answers) do
				if answers[i] == v.ans then v.correct = true self.Correct = self.Correct + 1 else
				v.correct = false
				self.Incorrect = self.Incorrect + 1 end
			end
			return self.Correct, self.Incorrect, self.Answers, self.Completed;
		end
		return smt(self, Form);
	end
}

return Form