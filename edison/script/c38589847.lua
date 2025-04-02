--アドバンス・フォース
function c38589847.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--summon with 1 tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc38589847(c38589847,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetCondition(c38589847.otcon)
	e2:SetTarget(aux.FieldSummonProcTg(c38589847.ottg,c38589847.ottgsum))
	e2:SetOperation(c38589847.otop)
	e2:SetValue(SUMMON_TYPE_TRIBUTE)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e3)
end
function c38589847.otfilter(c,tp)
	return c:IsLevelAbove(5) and (c:IsControler(tp) or c:IsFaceup())
end
function c38589847.otcon(e,c,minc)
	if c==nil then return true end
	if minc>1 then return false end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c38589847.otfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp)
	return Duel.CheckTribute(c,1,1,mg)
end
function c38589847.ottg(e,c)
	return c:IsLevelAbove(7)
end
function c38589847.ottgsum(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local mg=Duel.GetMatchingGroup(c38589847.otfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then
		mg:Match(Card.IsControler,nil,tp)
	end
	local sg=Duel.SelectTribute(tp,c,1,1,mg,nil,nil,true)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	end
	return false
end
function c38589847.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local sg=e:GetLabelObject()
	if not sg then return end
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
	sg:DeleteGroup()
end