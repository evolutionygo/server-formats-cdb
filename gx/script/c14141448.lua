--グレート・モス
--Great Moth
function c14141448.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c14141448.spcon)
	e1:SetTarget(c14141448.sptg)
	e1:SetOperation(c14141448.spop)
	c:RegisterEffect(e1)
end
c14141448.listed_names={40240595,58192742}
function c14141448.eqfilter(c)
	return c:IsCode(40240595) and c:GetTurnCounter()>=4
end
function c14141448.rfilter(c,ft,tp)
	return c:IsCode(58192742) and c:GetEquipGroup():IsExists(c14141448.eqfilter,1,nil)
end
function c14141448.spcon(e,c)
	if c==nil then return true end
	return Duel.CheckReleaseGroup(c:GetControler(),c14141448.rfilter,1,false,1,true,c,c:GetControler(),nil,false,nil)
end
function c14141448.sptg(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(tp,c14141448.rfilter,1,1,false,true,true,c,nil,nil,false,nil)
	if g then
		g:KeepAlive()
		e:SetLabelObject(g)
	return true
	end
	return false
end
function c14141448.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.Release(g,REASON_COST)
	g:DeleteGroup()
end