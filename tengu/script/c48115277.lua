--ブロックマン
--Blockman
function c48115277.initial_effect(c)
	--Register when it was placed on the field
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_NO_TURN_RESET)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetRange(LOCATION_MZONE)
	e0:SetCode(EVENT_ADJUST)
	e0:SetCountLimit(1)
	e0:SetOperation(c48115277.op)
	c:RegisterEffect(e0)
	--Check for how long it has been on the field
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_TURN_END)
	e1:SetCondition(c48115277.regcon)
	e1:SetOperation(c48115277.regop)
	c:RegisterEffect(e1)
	--Special summon tokens
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc48115277(c48115277,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c48115277.spcost)
	e2:SetTarget(c48115277.sptg)
	e2:SetOperation(c48115277.spop)
	c:RegisterEffect(e2)
end
c48115277.listed_names={48115278}
function c48115277.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsTurnPlayer(tp) then
		e:GetHandler():RegisterFlagEffect(c48115277,RESET_EVENT+RESETS_STANDARD,0,1,0)
	end
end
function c48115277.regcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsTurnPlayer(tp)
end
function c48115277.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetFlagEffectLabel(c48115277)
	if not ct then
		c:RegisterFlagEffect(c48115277,RESET_EVENT+RESETS_STANDARD,0,1,0)
	else
		c:SetFlagEffectLabel(c48115277,ct+1)
	end
end
function c48115277.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	local ct=e:GetHandler():GetFlagEffectLabel(c48115277)
	if not ct then ct=0 end
	e:SetLabel(ct)
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c48115277.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if e:GetHandler():GetSequence()<5 then ft=ft+1 end
	if chk==0 then
		local ct=e:GetHandler():GetFlagEffectLabel(c48115277)
		if not ct then ct=0 end
		return (ct==0 or not Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT)) and ft>ct-1
			and Duel.IsPlayerCanSpecialSummonMonster(tp,c48115277+1,0,TYPES_TOKEN,1000,1500,4,RACE_ROCK,ATTRIBUTE_EARTH)
	end
	local ct=e:GetLabel()
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ct+1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct+1,tp,0)
end
function c48115277.spop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	if ct>0 and Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>ct
		and Duel.IsPlayerCanSpecialSummonMonster(tp,c48115277+1,0,TYPES_TOKEN,1000,1500,4,RACE_ROCK,ATTRIBUTE_EARTH) then
		for i=1,ct+1 do
			local token=Duel.CreateToken(tp,c48115277+1)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			token:RegisterEffect(e1,true)
		end
		Duel.SpecialSummonComplete()
	end
end