--究極宝玉神 レインボー・ダーク・ドラゴン
--Rainbow Dark Dragon
function c79407975.initial_effect(c)
	c:EnableReviveLimit()
	--Special Summon Limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--Special summon procedure
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c79407975.spcon)
	e2:SetTarget(c79407975.sptg)
	e2:SetOperation(c79407975.spop)
	c:RegisterEffect(e2)
	--Increase ATK
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc79407975(c79407975,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c79407975.atkcost)
	e3:SetOperation(c79407975.atkop)
	c:RegisterEffect(e3)
end
function c79407975.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(1)(sg,e,tp,mg) and sg:GetClassCount(Card.GetCode)==#sg,sg:GetClassCount(Card.GetCode)~=#sg
end
function c79407975.spfilter(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsAbleToRemoveAsCost() and aux.SpElimFilter(c,true)
end
function c79407975.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local rg=Duel.GetMatchingGroup(c79407975.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	return aux.SelectUnselectGroup(rg,e,tp,7,7,c79407975.rescon,0)
end
function c79407975.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local rg=Duel.GetMatchingGroup(c79407975.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	local g=aux.SelectUnselectGroup(rg,e,tp,7,7,c79407975.rescon,1,tp,HINTMSG_REMOVE,nil,nil,true)
	if #g>0 then
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	return false
end
function c79407975.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	g:DeleteGroup()
end
function c79407975.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and aux.SpElimFilter(c,true,true)
end
function c79407975.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c79407975.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,e:GetHandler())
	if chk==0 then return #g>0 and g:FilterCount(Card.IsAbleToRemoveAsCost,nil)==#g end
	e:SetLabel(#g)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c79407975.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel()*500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE)
		c:RegisterEffect(e1)
	end
end