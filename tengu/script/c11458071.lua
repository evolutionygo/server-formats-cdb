--天魔神 エンライズ
--Sky Scourge Enrise
function c11458071.initial_effect(c)
	--Must be properly summoned before reviving
	c:EnableReviveLimit()
	--Must be special summon by its own method
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--Special summon procedure (from hand)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c11458071.spcon)
	e2:SetTarget(c11458071.sptg)
	e2:SetOperation(c11458071.spop)
	c:RegisterEffect(e2)
	--Banish 1 monster on the field
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc11458071(c11458071,0))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c11458071.rmcost)
	e3:SetTarget(c11458071.rmtg)
	e3:SetOperation(c11458071.rmop)
	c:RegisterEffect(e3)
end
function c11458071.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(1)(sg,e,tp,mg) and sg:IsExists(c11458071.atchk1,1,nil,sg)
end
function c11458071.atchk1(c,sg)
	return c:IsRace(RACE_FIEND) and c:IsAttribute(ATTRIBUTE_DARK) and sg:FilterCount(c11458071.atchk2,c)==3
end
function c11458071.atchk2(c)
	return c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c11458071.spfilter(c,rac,att)
	return c:IsRace(rac) and c:IsAttribute(att) and c:IsAbleToRemoveAsCost() and aux.SpElimFilter(c,true)
end
function c11458071.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local rg1=Duel.GetMatchingGroup(c11458071.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil,RACE_FAIRY,ATTRIBUTE_LIGHT)
	local rg2=Duel.GetMatchingGroup(c11458071.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil,RACE_FIEND,ATTRIBUTE_DARK)
	local rg=rg1:Clone()
	rg:Merge(rg2)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-4 and #rg1>2 and #rg2>0 
		and aux.SelectUnselectGroup(rg,e,tp,4,4,c11458071.rescon,0)
end
function c11458071.sptg(e,tp,eg,ep,ev,re,r,rp,c)
	local rg=Duel.GetMatchingGroup(c11458071.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil,RACE_FAIRY,ATTRIBUTE_LIGHT)
	rg:Merge(Duel.GetMatchingGroup(c11458071.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil,RACE_FIEND,ATTRIBUTE_DARK))
	local g=aux.SelectUnselectGroup(rg,e,tp,4,4,c11458071.rescon,1,tp,HINTMSG_REMOVE,nil,nil,true)
	if #g>0 then
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	return false
end
function c11458071.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	g:DeleteGroup()
end
function c11458071.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 end
	--Cannot attack this turn
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(3206)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1,true)
end
function c11458071.tgfilter(c)
	return c:IsFaceup() and c:IsAbleToRemove()
end
function c11458071.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c11458071.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c11458071.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c11458071.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c11458071.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end