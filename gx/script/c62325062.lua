--粘着落とし穴
--Adhesion Trap Hole
function c62325062.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c62325062.target)
	e1:SetOperation(c62325062.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c62325062.filter(c,tp)
	return c:IsFaceup() and c:IsSummonPlayer(1-tp) and c:IsLocation(LOCATION_MZONE)
end
function c62325062.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c62325062.filter,1,nil,tp) end
	Duel.SetTargetCard(eg)
end
function c62325062.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetTargetCards(e):Match(c62325062.filter,nil,tp)
	for tc in aux.Next(tg) do
		--Halve its original ATK
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(tc:GetBaseAttack()/2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end