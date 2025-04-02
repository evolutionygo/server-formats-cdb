--ヴァンパイアジェネシス
--Vampire Genesis
function c22056710.initial_effect(c)
	c:EnableReviveLimit()
	c:AddMustBeSpecialSummoned()
	--Must be Special Summoned (from your hand) by banishing 1 "Vampire Lord" from your Monster Zone
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc22056710(c22056710,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c22056710.selfspcon)
	e1:SetTarget(c22056710.selfsptg)
	e1:SetOperation(c22056710.selfspop)
	c:RegisterEffect(e1)
	--Special Summon 1 Zombie monster from your GY
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc22056710(c22056710,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c22056710.gysptg)
	e2:SetOperation(c22056710.gyspop)
	c:RegisterEffect(e2)
end
c22056710.listed_names={53839837} --"Vampire Lord"
function c22056710.selfspconfilter(c)
	return c:IsCode(53839837) and c:IsFaceup() and c:IsAbleToRemoveAsCost()
end
function c22056710.selfspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c22056710.selfspconfilter,tp,LOCATION_MZONE,0,nil)
	return #g>0 and Duel.GetMZoneCount(tp,g)>0
end
function c22056710.selfsptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local rg=Duel.GetMatchingGroup(c22056710.selfspconfilter,tp,LOCATION_MZONE,0,nil)
	local g=aux.SelectUnselectGroup(rg,e,tp,1,1,aux.ChkfMMZ(1),1,tp,HINTMSG_REMOVE,nil,nil,true)
	if #g>0 then
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	return false
end
function c22056710.selfspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	g:DeleteGroup()
end
function c22056710.gyspcostfilter(c,e,tp)
	return c:IsRace(RACE_ZOMBIE) and c:IsDiscardable()
		and Duel.IsExistingTarget(c22056710.gyspfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,c:GetLevel()-1)
end
function c22056710.gyspfilter(c,e,tp,lv)
	return c:IsRace(RACE_ZOMBIE) and c:IsLevelBetween(1,lv) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c22056710.gysptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c22056710.gyspfilter(chkc,e,tp,e:GetLabel()) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c22056710.gyspcostfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local dc=Duel.SelectMatchingCard(tp,c22056710.gyspcostfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp):GetFirst()
	Duel.SendtoGrave(dc,REASON_COST|REASON_DISCARD)
	local lv=dc:GetLevel()-1
	e:SetLabel(lv)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectTarget(tp,c22056710.gyspfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,lv)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tg,1,tp,0)
end
function c22056710.gyspop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end