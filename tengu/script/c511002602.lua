--ＢＦ－極光のアウロラ (Anime)
--Blackwing - Aurora the Northern Lights (Anime)
function c511002602.initial_effect(c)
	c:EnableReviveLimit()
	--Special Summon proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511002602.spcon)
	e1:SetTarget(c511002602.sptg)
	e1:SetOperation(c511002602.spop)
	c:RegisterEffect(e1)
	--copy effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511002602(4068622,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511002602.target)
	e2:SetOperation(c511002602.operation)
	c:RegisterEffect(e2)
	--Special Summon limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	e3:SetValue(aux.FALSE)
	c:RegisterEffect(e3)
end
c511002602.listed_series={0x33}
function c511002602.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(1)(sg,e,tp,mg) and sg:IsExists(c511002602.spfilter1,1,nil,sg) and sg:IsExists(c511002602.spfilter2,1,nil,sg)
end
function c511002602.spfilter1(c)
	return not c:IsType(TYPE_TUNER)
end
function c511002602.spfilter2(c)
	return c:IsSetCard(0x33) and c:IsType(TYPE_TUNER)
end
function c511002602.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local rg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	local g1=rg:Filter(c511002602.spfilter1,nil)
	local g2=rg:Filter(c511002602.spfilter2,nil)
	local g=g1:Clone()
	g:Merge(g2)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2 and #g1>0 and #g2>0 and #g>1 
		and aux.SelectUnselectGroup(g,e,tp,2,2,c511002602.rescon,0)
end
function c511002602.sptg(e,tp,eg,ep,ev,re,r,rp,c)
	local rg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	local g1=rg:Filter(c511002602.spfilter1,nil)
	local g2=rg:Filter(c511002602.spfilter2,nil)
	g1:Merge(g2)
	local sg=aux.SelectUnselectGroup(g1,e,tp,2,2,c511002602.rescon,1,tp,HINTMSG_REMOVE,nil,nil,true)
	if #sg>0 then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	end
	return false
end
function c511002602.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	local lvl=g:GetFirst():GetLevel()+g:GetNext():GetLevel()
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	--change Level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(lvl)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
	c:RegisterEffect(e1)
	g:DeleteGroup()
end
function c511002602.filter(c,lv)
	return c:IsSetCard(0x33) and c:IsType(TYPE_SYNCHRO) and c:IsAbleToRemove() and c:IsLevel(lv)
end
function c511002602.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002602.filter,tp,LOCATION_EXTRA,0,1,nil,e:GetHandler():GetLevel()) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,0,tp,LOCATION_EXTRA)
end
function c511002602.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=Duel.SelectMatchingCard(tp,c511002602.filter,tp,LOCATION_EXTRA,0,1,1,nil,c:GetLevel()):GetFirst()
	if tc and c:IsFaceup() and c:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0 then
		local code=tc:GetOriginalCode()
		local ba=tc:GetBaseAttack()
		c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN, 1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(ba)
		c:RegisterEffect(e1)
	end
end