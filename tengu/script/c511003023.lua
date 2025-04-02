--血の代償
--Ultimate Offering (pre-errata)
function c511003023.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Normal Summon/Set
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc511003023(80604091,0))
	e3:SetCategory(CATEGORY_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCost(c511003023.cost)
	e3:SetTarget(c511003023.target)
	e3:SetOperation(c511003023.activate)
	c:RegisterEffect(e3)
end
function c511003023.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	if e:GetHandler():GetFlagEffect(c511003023)==0 then
		e:GetHandler():RegisterFlagEffect(c511003023,RESET_CHAIN,0,1,Duel.GetMatchingGroupCount(Card.CanSummonOrSet,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,true,nil))
	end
	Duel.PayLPCost(tp,500)
end
function c511003023.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetHandler():GetFlagEffect(c511003023)==0 then
			return Duel.GetMatchingGroupCount(Card.CanSummonOrSet,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,true,nil)>0
		else return e:GetHandler():GetFlagEffectLabel(c511003023)>0 end
	end
	e:GetHandler():SetFlagEffectLabel(c511003023,e:GetHandler():GetFlagEffectLabel(c511003023)-1)
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c511003023.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local tc=Duel.SelectMatchingCard(tp,Card.CanSummonOrSet,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,true,nil):GetFirst()
	if tc then
		Duel.SummonOrSet(tp,tc,true,nil)
	end
end