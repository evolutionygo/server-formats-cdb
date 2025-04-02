--魂のリレー (Anime)
--Relay Soul (Anime)
--scripted by edo9300, fixes by MLD
Duel.EnableUnofficialProc(PROC_EVENT_LP0)
function c511002521.initial_effect(c)
	--Survive
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511002521(c511002521,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_LP0)
	e1:SetTarget(c511002521.target)
	e1:SetOperation(c511002521.activate)
	c:RegisterEffect(e1)
	aux.LP0ActivationValc511002521ity(e1)
end
function c511002521.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002521.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002521.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_CHAIN)
	e1:SetCode(EFFECT_CANNOT_LOSE_LP)
	Duel.RegisterEffect(e1,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511002521.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=e:GetHandlerPlayer()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002521.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_LOSE_DECK)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetLabel(1)
		e1:SetLabelObject(tc)
		e1:SetCondition(c511002521.con)
		Duel.RegisterEffect(e1,tp)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_LOSE_LP)
		Duel.RegisterEffect(e2,tp)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CANNOT_LOSE_EFFECT)
		tc:RegisterEffect(e3)
		Duel.RegisterEffect(e3,tp)
		local e4=Effect.CreateEffect(e:GetHandler())
		e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e4:SetCode(EVENT_LEAVE_FIELD)
		e4:SetLabel(1-tp)
		e4:SetCondition(c511002521.losecon)
		e4:SetOperation(c511002521.loseop)
		e4:SetReset(RESET_EVENT|RESET_TURN_SET|RESET_OVERLAY|RESET_MSCHANGE)
		tc:RegisterEffect(e4,true)
		Duel.SpecialSummonComplete()
	end
end
function c511002521.losecon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c511002521.loseop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Win(e:GetLabel(),WIN_REASON_RELAY_SOUL)
end
function c511002521.con(e)
	if e:GetLabelObject() and not e:GetLabelObject():IsReason(REASON_DESTROY) then
		return true
	end
	if e:GetLabel()==0 then
		e:SetLabelObject(nil)
		return false
	else
		e:SetLabel(0)
	end
	return false
end