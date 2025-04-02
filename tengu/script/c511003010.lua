--超融合 (Anime)
--Super Polymerization (Anime)
function c511003010.initial_effect(c)
	--Activate
	local e1=Fusion.CreateSummonEff{handler=c,matfilter=Fusion.OnFieldMat,extrafil=c511003010.fextra,extratg=c511003010.extratg,extraop=c511003010.extraop}
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER_E)
	e1:SetCost(c511003010.cost)
	c:RegisterEffect(e1)
end
function c511003010.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsAbleToGraveAsCost,1,1,REASON_COST)
end
function c511003010.check(tp,sg,fc)
	return sg:IsExists(Card.IsControler,1,nil,tp)
end
function c511003010.filter(c,p)
	return c:IsFaceup() or c:IsControler(p)
end
function c511003010.fextra(e,tp,mg)
	return Duel.GetMatchingGroup(c511003010.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,tp),c511003010.check
end
function c511003010.extratg(e,tp,eg,ep,ev,re,r,rp,chk)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		Duel.SetChainLimit(aux.FALSE)
	end
end
function c511003010.extraop(e,tc,tp,mat)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c511003010.sumsuc)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD&~RESET_TOFIELD)
	tc:RegisterEffect(e1,true)
end
function c511003010.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(aux.FALSE)
end