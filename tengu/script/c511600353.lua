--－Ａｉ－Ｑ (Anime)
--A.I.Q (Anime)
--Scripted by Larry126
function c511600353.initial_effect(c)
	--Activated
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Limited Link Summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511600353.spcon)
	e2:SetOperation(c511600353.spop)
	c:RegisterEffect(e2)
	--Maintain
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCondition(c511600353.descon)
	e3:SetOperation(c511600353.desop)
	c:RegisterEffect(e3)
end
function c511600353.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsSummonType,1,nil,SUMMON_TYPE_LINK)
end
function c511600353.spop(e,tp,eg,ep,ev,re,r,rp)
	local players=eg:Filter(Card.IsSummonType,nil,SUMMON_TYPE_LINK):GetClass(Card.GetSummonPlayer)
	local c=e:GetHandler()
	for _,p in ipairs(players) do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetAbsoluteRange(0,p==0 and 1 or 0,p==1 and 1 or 0)
		e1:SetRange(LOCATION_SZONE)
		e1:SetTarget(c511600353.splimit)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
	end
end
function c511600353.filter(c,fc511600353)
	return c:GetFieldID()==fc511600353
end
function c511600353.con(e)
	if Duel.IsExistingMatchingCard(c511600353.filter,0,LOCATION_SZONE,LOCATION_SZONE,1,nil,e:GetLabel()) then return true
	else e:Reset() return false end
end
function c511600353.splimit(e,c,sump,sumtype,sumpos,targetp)
	return sumtype&SUMMON_TYPE_LINK==SUMMON_TYPE_LINK
end
function c511600353.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511600353.desfilter(c)
	return c:IsReleasableByEffect() and c:IsType(TYPE_LINK)
end
function c511600353.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.HintSelection(Group.FromCards(c))
	if Duel.CheckReleaseGroup(tp,c511600353.desfilter,1,nil) and Duel.SelectEffectYesNo(tp,c) then
		local g=Duel.SelectReleaseGroup(tp,c511600353.desfilter,1,1,nil)
		Duel.Release(g,REASON_COST)
	else Duel.Destroy(c,REASON_COST) end
end