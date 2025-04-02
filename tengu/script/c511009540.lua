--ＤＤヴァイス・テュポーン (Anime)
--D/D Vice Typhon (Anime)
function c511009540.initial_effect(c)
	--Register effect when it is sent to grave
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetOperation(c511009540.regop)
	c:RegisterEffect(e1)
end
c511009540.listed_series={SET_DDD}
function c511009540.regop(e,tp,eg,ep,ev,re,r,rp)
	local params={fusfilter=aux.FilterBoolFunction(Card.IsSetCard,SET_DDD),matfilter=aux.FALSE,extrafil=c511009540.fextra,extraop=Fusion.BanishMaterial,gc=Fusion.ForcedHandler,extratg=c511009540.extratg}
	local c=e:GetHandler()
	--Fusion Summon 1 "D/D/D" monster
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511009540(c511009540,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTarget(Fusion.SummonEffTG(params))
	e1:SetOperation(Fusion.SummonEffOP(params))
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
function c511009540.fextra(e,tp,mg)
	if not Duel.IsPlayerAffectedByEffect(tp,69832741) then
		return Duel.GetMatchingGroup(Fusion.IsMonsterFilter(Card.IsAbleToRemove),tp,LOCATION_GRAVE,0,nil)
	end
	return nil
end
function c511009540.extratg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,tp,LOCATION_GRAVE)
end