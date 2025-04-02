--E・HERO バブルマン・ネオ
--Elemental HERO Neo Bubbleman
function c5285665.initial_effect(c)
	c:EnableReviveLimit()
	--Cannot be Special Summoned, except by its own effect
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--Special Summon procedure
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c5285665.spcon)
	e2:SetTarget(c5285665.sptg)
	e2:SetOperation(c5285665.spop)
	c:RegisterEffect(e2)
	--This card's name becomes "Elemental HERO Bubbleman"
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CHANGE_CODE)
	e3:SetValue(79979666)
	c:RegisterEffect(e3)
	--Destroy a monster that battles with this card
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc5285665(c5285665,0))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_DAMAGE_STEP_END)
	e4:SetTarget(c5285665.destg)
	e4:SetOperation(c5285665.desop)
	c:RegisterEffect(e4)
end
c5285665.listed_names={79979666,46411259} --Elemental HERO Bubbleman, Metamorphosis
function c5285665.spfilter(c,...)
	return c:IsCode(...) and c:IsAbleToGraveAsCost()
end
function c5285665.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(1)(sg,e,tp,mg) and sg:IsExists(c5285665.chk,1,nil,sg)
end
function c5285665.chk(c,sg)
	return c:IsCode(79979666) and sg:IsExists(Card.IsCode,1,c,46411259)
end
function c5285665.spcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	local g1=Duel.GetMatchingGroup(c5285665.spfilter,tp,LOCATION_MZONE,0,nil,79979666)
	local g2=Duel.GetMatchingGroup(c5285665.spfilter,tp,LOCATION_HAND,0,nil,46411259)
	local g=g1:Clone()
	g:Merge(g2)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and #g1>0 and #g2>0
		and aux.SelectUnselectGroup(g,e,tp,2,2,c5285665.rescon,0)
end
function c5285665.sptg(e,tp,eg,ep,ev,re,r,rp,c)
	local sg=Duel.GetMatchingGroup(c5285665.spfilter,tp,LOCATION_MZONE,0,nil,79979666)
	sg:Merge(Duel.GetMatchingGroup(c5285665.spfilter,tp,LOCATION_HAND,0,nil,46411259))
	local g=aux.SelectUnselectGroup(sg,e,tp,2,2,c5285665.rescon,1,tp,HINTMSG_TOGRAVE,nil,nil,true)
	if #g>0 then
		g:KeepAlive()
		e:SetLabelObject(g)
	return true
	end
	return false
end
function c5285665.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.SendtoGrave(g,REASON_COST)
	g:DeleteGroup()
end
function c5285665.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetBattleTarget()
	if chk==0 then return bc and bc:IsRelateToBattle() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c5285665.desop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc and bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end