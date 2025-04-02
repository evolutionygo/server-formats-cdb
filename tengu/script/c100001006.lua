--九尾の狐 (Manga)
--Nine-Tailed Fox (Manga)
Duel.EnableUnofficialRace(RACE_YOKAI)
function c100001006.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc100001006(c100001006,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c100001006.spcon)
	e1:SetTarget(c100001006.sptg)
	e1:SetOperation(c100001006.spop)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetCondition(c100001006.pcon)
	c:RegisterEffect(e2)
	--token
	local e3=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc100001006(c100001006,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetTarget(c100001006.target)
	e3:SetOperation(c100001006.operation)
	c:RegisterEffect(e3)
end
function c100001006.spcon(e,c)
	if c==nil then return true end
	return Duel.CheckReleaseGroup(c:GetControler(),Card.IsRace,2,false,2,true,c,c:GetControler(),nil,false,nil,RACE_YOKAI)
end
function c100001006.sptg(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(tp,Card.IsRace,2,2,false,true,true,c,nil,nil,false,nil,RACE_YOKAI)
	if g then
		g:KeepAlive()
		e:SetLabelObject(g)
	return true
	end
	return false
end
function c100001006.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.Release(g,REASON_COST)
	g:DeleteGroup()
end
function c100001006.pcon(e)
	return e:GetHandler():IsPreviousLocation(LOCATION_GRAVE)
end
function c100001006.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,0)
end
function c100001006.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) or ft<2
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,c100001006+1,0,TYPES_TOKEN,500,500,2,RACE_YOKAI,ATTRIBUTE_FIRE) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,c100001006+1)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end