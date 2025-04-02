--ライノタウルス
--Rhinotaurus
function c83957459.initial_effect(c)
	--Second attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetCondition(c83957459.macon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	aux.GlobalCheck(s,function()
		s[0]=0
		s[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLE_DESTROYING)
		ge1:SetOperation(c83957459.checkop)
		Duel.RegisterEffect(ge1,0)
		aux.AddValuesReset(function()
			s[0]=0
			s[1]=0
		end)
	end)
end
function c83957459.checkop(e,tp,eg,ep,ev,re,r,rp)
	local bc=eg:GetFirst()
	local cp=bc:GetControler()
	if not bc:IsRelateToBattle() then cp=bc:GetPreviousControler() end
	s[cp]=s[cp]+1
end
function c83957459.macon(e)
	return s[e:GetHandlerPlayer()]>=2
end