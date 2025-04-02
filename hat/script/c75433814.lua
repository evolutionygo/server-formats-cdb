--No.40 ギミック・パペット－ヘブンズ・ストリングス
--Number 40: Gimmick Puppet of Strings
function c75433814.initial_effect(c)
	--Xyz Summon
	aux.AddXyzProcedure(c,nil,8,2)
	c:EnableReviveLimit()
	--Place String counters
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc75433814(c75433814,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(aux.dxmcostgen(1,1,nil))
	e1:SetTarget(c75433814.cttg)
	e1:SetOperation(c75433814.ctop)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
	--Destroy monsters with String counters and burn 500 for each
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc75433814(c75433814,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c75433814.descon)
	e2:SetTarget(c75433814.destg)
	e2:SetOperation(c75433814.desop)
	c:RegisterEffect(e2)
end
c75433814.counter_place_list={0x1024}
c75433814.aux.xyz_number=40
function c75433814.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
end
function c75433814.ctop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	for tc in g:Iter() do
		tc:AddCounter(0x1024,1)
	end
	Duel.RegisterFlagEffect(tp,c75433814,RESET_PHASE+PHASE_END,0,2)
end
function c75433814.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,c75433814)~=0 and Duel.GetTurnPlayer()~=tp
end
function c75433814.desfilter(c)
	return c:GetCounter(0x1024)~=0
end
function c75433814.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75433814.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c75433814.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,#g*500)
end
function c75433814.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c75433814.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	Duel.Damage(1-tp,ct*500,REASON_EFFECT)
end