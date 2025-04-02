--磁石の戦士マグネット・バルキリオン (Anime)
--Valkyrion the Magna Warrior (Anime)
--Updated by Larry126
function c511000462.initial_effect(c)
	aux.AddFusionProcCode2(c,true,true,99785935,39256679,11549357)
	Fusion.AddContactProc(c,c511000462.contactfilter,c511000462.contactop,c511000462.splimit,nil,SUMMON_TYPE_FUSION)
end
c511000462.material_setcode={0x66,0x2066}
c511000462.listed_series={0x66,0x2066}
c511000462.listed_names={99785935,39256679,11549357}
function c511000462.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c511000462.contactfilter(tp)
	return Duel.GetMatchingGroup(Card.IsAbleToGraveAsCost,tp,LOCATION_ONFIELD,0,nil)
end
function c511000462.contactop(g,tp,c)
	Duel.SendtoGrave(g,REASON_COST+REASON_MATERIAL+REASON_FUSION)
end