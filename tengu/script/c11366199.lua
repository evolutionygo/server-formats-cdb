--ダーク・シムルグ
--Dark Simorgh
function c11366199.initial_effect(c)
	--Add WIND attribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_ATTRIBUTE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(ATTRIBUTE_WIND)
	c:RegisterEffect(e1)
	--Special summon itself from the hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc11366199(c11366199,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCost(c11366199.spcost1)
	e2:SetTarget(c11366199.sptg)
	e2:SetOperation(c11366199.spop)
	c:RegisterEffect(e2)
	--Special summon itself from the grave
	local e3=e2:Clone()
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(c11366199.spcost2)
	c:RegisterEffect(e3)
	--Cannot set
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_MSET)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,1)
	e4:SetTarget(aux.TRUE)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CANNOT_SSET)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EFFECT_CANNOT_TURN_SET)
	c:RegisterEffect(e6)
	local e7=e4:Clone()
	e7:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e7:SetTarget(c11366199.sumlimit)
	c:RegisterEffect(e7)
end
function c11366199.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return (sumpos&POS_FACEDOWN)>0
end
function c11366199.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(1)(sg,e,tp,mg) and sg:IsExists(c11366199.atchk1,1,nil,sg)
end
function c11366199.atchk1(c,sg)
	return c:IsAttribute(ATTRIBUTE_WIND) and sg:FilterCount(Card.IsAttribute,c,ATTRIBUTE_DARK)==1
end
function c11366199.spfilter1(c,att)
	return c:IsAttribute(att) and c:IsAbleToRemoveAsCost() and aux.SpElimFilter(c,true)
end
function c11366199.spcost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local rg1=Duel.GetMatchingGroup(c11366199.spfilter1,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil,ATTRIBUTE_WIND)
	local rg2=Duel.GetMatchingGroup(c11366199.spfilter1,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil,ATTRIBUTE_DARK)
	local rg=rg1:Clone()
	rg:Merge(rg2)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-2 and #rg1>0 and #rg2>0 and aux.SelectUnselectGroup(rg,e,tp,2,2,c11366199.rescon,0) end
	local g=aux.SelectUnselectGroup(rg,e,tp,2,2,c11366199.rescon,1,tp,HINTMSG_REMOVE,nil,nil,false)
	if #g==2 then
		Duel.Remove(g,POS_FACEUP,REASON_COST)
	end
end
function c11366199.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c11366199.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c11366199.spfilter2(c,att)
	return c:IsAttribute(att) and c:IsAbleToRemoveAsCost()
end
function c11366199.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local rg1=Duel.GetMatchingGroup(c11366199.spfilter2,tp,LOCATION_HAND,0,nil,ATTRIBUTE_WIND)
	local rg2=Duel.GetMatchingGroup(c11366199.spfilter2,tp,LOCATION_HAND,0,nil,ATTRIBUTE_DARK)
	local rg=rg1:Clone()
	rg:Merge(rg2)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-2 and #rg1>0 and #rg2>0 and aux.SelectUnselectGroup(rg,e,tp,2,2,c11366199.rescon,0) end
	local g=aux.SelectUnselectGroup(rg,e,tp,2,2,c11366199.rescon,1,tp,HINTMSG_REMOVE,nil,nil,false)
	if #g==2 then
		Duel.Remove(g,POS_FACEUP,REASON_COST)
	end
end